// s3 access policy for ec2 instance
// avs.dev/prod.zixiao.wang
resource "aws_iam_policy" "s3_access_role_policy" {
  name        = var.project_name+"S3"

  policy = file(var.s3_role_policy)
  depends_on = [aws_iam_role.s3_access_role]
}

resource "aws_iam_role_policy_attachment" "s3_access_role_policy-attach" {
  role       = aws_iam_role.s3_access_role.name // attach to role EC2-AVS
  policy_arn = aws_iam_policy.s3_access_role_policy.arn // Policy avsS3

  depends_on = [aws_iam_role.s3_access_role]
}

// CodeDeploy-EC2-S3 Policy for the Server (EC2)
// Get List avs.codedeploy.dev/prod.brickea.me
resource "aws_iam_policy" "s3_codeDeply_role_policy" {
  name        = var.project_name+"CodeDeploy-EC2-S3"

  policy = file(var.s3_codeDeploy_role_policy)
  depends_on = [aws_iam_role.s3_access_role]
}

resource "aws_iam_role_policy_attachment" "s3_codeDeply_role_policy-attach" {
  role       = aws_iam_role.s3_access_role.name // attach to role EC2-AVS
  policy_arn = aws_iam_policy.s3_codeDeply_role_policy.arn // Policy CodeDeploy-EC2-S3

  depends_on = [aws_iam_role.s3_access_role]
}

resource "aws_iam_user_policy_attachment" "s3_codeDeply_user_policy-attach" {
  user       = "cicd"
  policy_arn = aws_iam_policy.s3_codeDeply_role_policy.arn // Policy CodeDeploy-EC2-S3
}

// GH-Upload-To-S3 Policy for GitHub Actions to Upload to AWS S3
// Get Put List avs.codedeploy.dev/prod.brickea.me
resource "aws_iam_policy" "s3_ghUpLoad_role_policy" {
  name        = var.project_name+"GH-Upload-To-S3"

  policy = file(var.s3_ghUpload_role_policy)
  depends_on = [aws_iam_role.gitaction_access_role]
}

resource "aws_iam_role_policy_attachment" "s3_ghUpLoad_role_policy-attach" {
  role       = aws_iam_role.gitaction_access_role.name  // attach to role GIT-ACTION
  policy_arn = aws_iam_policy.s3_ghUpLoad_role_policy.arn // Policy GH-Upload-To-S3

  depends_on = [aws_iam_role.gitaction_access_role]
}

resource "aws_iam_user_policy_attachment" "s3_ghUpLoad_user_policy-attach" {
  user       = "cicd"
  policy_arn = aws_iam_policy.s3_ghUpLoad_role_policy.arn
}

// GH-Code-Deploy Policy for GitHub Actions to Call CodeDeploy
resource "aws_iam_policy" "gh_code_deploy_call_codeDeply_policy" {
  name        = var.project_name+"GH-Code-Deploy"
  
  policy = file(var.gh_code_deploy_call_codeDeply_policy)
  depends_on = [aws_iam_role.gitaction_access_role]
}

resource "aws_iam_role_policy_attachment" "gh_code_deploy_call_codeDeply_policy-attach" {
  role       = aws_iam_role.gitaction_access_role.name // attach to role GIT-ACTION
  policy_arn = aws_iam_policy.gh_code_deploy_call_codeDeply_policy.arn // Policy GH-Code-Deploy

  depends_on = [aws_iam_role.gitaction_access_role]
}

resource "aws_iam_user_policy_attachment" "gh_code_deploy_call_codeDeply_user_policy-attach" {
  user       = "cicd"
  policy_arn = aws_iam_policy.gh_code_deploy_call_codeDeply_policy.arn
}

// gh-ec2-ami Policy for GitHub Actions to Call CodeDeploy
resource "aws_iam_policy" "gh_ec2_ami_policy" {
  name        = var.project_name+"gh-ec2-ami"

  policy = file("policies/gh-ec2-ami.json")
  depends_on = [aws_iam_role.gitaction_access_role]
}

resource "aws_iam_role_policy_attachment" "gh_ec2_ami_policy-attach" {
  role       = aws_iam_role.gitaction_access_role.name
  policy_arn = aws_iam_policy.gh_ec2_ami_policy.arn

  depends_on = [aws_iam_role.gitaction_access_role]
}

// AWSCodeDeployPolicy
resource "aws_iam_role_policy_attachment" "AWSCodeDeployRole" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
  role       = aws_iam_role.codeDeployService_access_role.name
}

//*********************************************************************************

// s3 access roles for ec2 instance
resource "aws_iam_role" "s3_access_role" {
  name = var.project_name+"EC2-AVS"

  assume_role_policy = file("policies/s3_role_assume_policy.json")
}

// gitaction role
resource "aws_iam_role" "gitaction_access_role" {
  name = var.project_name+"GIT-ACTION"

  assume_role_policy = file("policies/s3_role_assume_policy.json")
}


// codedeploy service role
resource "aws_iam_role" "codeDeployService_access_role" {
  name = var.project_name+"CodeDeployServiceRole"

  assume_role_policy = file("policies/codedeploy_assume_policy.json")
}

//*********************************************************************************\

// User profile for ec2 instance
resource "aws_iam_instance_profile" "s3_access_profile" {
  name = var.project_name+"s3-access"
  role = aws_iam_role.s3_access_role.name
}

// User for GH-Code-Deploy Policy for GitHub Actions to Call CodeDeploy
resource "aws_iam_instance_profile" "GH-Code-Deploy_s3_access_profile" {
  name = var.project_name+"ghactions"
  role = aws_iam_role.gitaction_access_role.name
}
