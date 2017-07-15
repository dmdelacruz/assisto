<?php
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

$app = new \Slim\App;

$app->get('/api/users', function (Request $request, Response $response){
    $sql = "SELECT * FROM users";

    try {
        // Get db obj
        $db = new db();
        $db = $db->connect();

        $stmt = $db->query($sql);
        $users = $stmt->fetchAll(PDO::FETCH_OBJ);
        $db = null;

        $data = array("status" => true, "data" => $users);
    } catch (PDOException $e) {
        $data = array("status" => false, "data" => $e->getMessage());
    }
    return $response->withJson($data);
});

//Get single user
$app->get('/api/user/{id}', function (Request $request, Response $response){
    $id = $request->getAttribute('id');

    $sql = "SELECT * FROM users WHERE cod_user={$id}";

    try {
        // Get db obj
        $db = new db();
        $db = $db->connect();

        $stmt = $db->query($sql);
        $users = $stmt->fetchAll(PDO::FETCH_OBJ);
        $db = null;

        $data = array("status" => true, "data" => $users);
    } catch (PDOException $e) {
        $data = array("status" => false, "data" => $e->getMessage());
    }

    return $response->withJson($data);
});

//Add user
$app->post('/api/user/add', function (Request $request, Response $response){
    $firstname = $request->getParam('firstname');
    $lastname = $request->getParam('lastname');
    $email = $request->getParam('email');
    $username = $request->getParam('username');
    $password = password_hash($request->getParam('password'), PASSWORD_BCRYPT);
    $created_at = date("Y-m-d H:i:s");

    $sql = "INSERT INTO users (firstname, lastname, email, username, password, created_at) VALUES 
            (:firstname, :lastname, :email, :username, :password, :created_at)";

    try {
        // Get db obj
        $db = new db();
        $db = $db->connect();

        $stmt = $db->prepare($sql);

        $stmt->bindParam(':firstname', $firstname);
        $stmt->bindParam(':lastname', $lastname);
        $stmt->bindParam(':email', $email);
        $stmt->bindParam(':username', $username);
        $stmt->bindParam(':password', $password);
        $stmt->bindParam(':created_at', $created_at);

        $stmt->execute();
        $data = array("status" => true, "data" => "User added");
    } catch (PDOException $e) {
        $data = array("status" => false, "data" => $e->getMessage());
    }
    return $response->withJson($data);
});

$app->post('/api/user/login', function (Request $request, Response $response){

    $email = $request->getParam('email');
    $password = $request->getParam('password');

    if (!isset($email) || !isset($password)) {
        return $response->withJson(array("status" => false, "data" => "There are a credential missing"));
    }

    try {
        // Get db obj
        $db = new db();
        $db = $db->connect();

        $sql = "SELECT email, password FROM users WHERE email = ?";

        $stmt = $db->prepare($sql);
        $stmt->execute(array($email));
        $credentials = $stmt->fetch(PDO::FETCH_OBJ);
    } catch (PDOException $e) {
        return $response->withJson(array("status" => false, "data" => $e->getMessage()));
    }

    $logged_in = false;
    $data = "Incorrect credentials";
    if (isset($credentials) && is_object($credentials)) {
        if (password_verify($password, $credentials->password)) {
            $logged_in = true;
            $data = "login correct";
        }
    }

    return $response->withJson(array("status" => $logged_in, "data" => $data));
});