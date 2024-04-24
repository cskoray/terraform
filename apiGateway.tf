resource "aws_apigatewayv2_api" "aslan-gw" {
  name          = "aslan-gw"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_prod" "prod" {
  api_id = aws_apigatewayv2_api.aslan-gw.id

  name        = "prod"
  auto_deploy = true
}

resource "aws_apigatewayv2_integration" "aslan-gw" {
  api_id = aws_apigatewayv2_api.aslan-gw.id

  integration_type   = "HTTP_PROXY"
  integration_uri    = "http://${aws_instance.app-server.18.130.226.136}:8080/{proxy}"
  integration_method = "ANY"
  connection_type    = "INTERNET"
}

resource "aws_apigatewayv2_route" "aslan-gw" {
  api_id = aws_apigatewayv2_api.aslan-gw.id

  route_key = "ANY /{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.aslan-gw.id}"
}

output "aslan-gw_health_url" {
  value = "${aws_apigatewayv2_prod.prod.invoke_url}/health"
}
