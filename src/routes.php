<?php
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

// Routes

$app->get('/[{name}]', function (Request $request, Response $response, $args) {
    // Sample log message
    $this->logger->info("Slim-Skeleton '/' route");

    // Render index view
    return $this->renderer->render($response, 'index.phtml', $args);
});

$app->get('/user/[{name}]', function (Request $request, Response $response, $args) {
    $name = (string)$args['name'];
    $todos = array("status" => true, "msg" => "Hola ".$name);
    return $this->response->withJson($todos);
});

$app->post('/user/create', function (Request $request, Response $response) {
    $input = $request->getParsedBody();
    $sql = "INSERT INTO user (user_name, user_lastname, user_phone, user_email, user_password) VALUES (:user_name, :user_lastname, :user_phone, :user_email, :user_password)";
    $sth = $this->db->prepare($sql);

    $sth->bindParam(":user_name", $input['user_name']);
    $sth->bindParam(":user_lastname", $input['user_lastname']);
    $sth->bindParam(":user_phone", $input['user_phone']);
    $sth->bindParam(":user_email", $input['user_email']);
    $sth->bindParam(":user_password", $input['user_password']);

    $sth->execute();
    $input['id'] = $this->db->lastInsertId();
    return $this->response->withJson($input);
});

