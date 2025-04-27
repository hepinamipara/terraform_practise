// like this we can create 
module "lambda" {
  source        = "./modules/lambda"
  lambda_filename = "filename"
  lambda_function_name = "funcname"
  lambda_handler = "lambda_handler"
  lambda_runtime = "python 3.9"
}
