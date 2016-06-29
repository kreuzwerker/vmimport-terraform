provider "aws" {
  region = "${var.region}"
}

resource "aws_iam_role" "vmimport" {
  name = "vmimport"
  assume_role_policy = "${file("${path.module}/trust_policies/vmie.json")}"
}

resource "aws_iam_role_policy" "vmimport_policy" {
    name = "vmimport_policy"
    role = "${aws_iam_role.vmimport.id}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket",
        "s3:GetBucketLocation"
      ],
      "Resource": [
        "${aws_s3_bucket.bucket.arn}"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject"
      ],
      "Resource": [
        "${aws_s3_bucket.bucket.arn}/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:ModifySnapshotAttribute",
        "ec2:CopySnapshot",
        "ec2:RegisterImage",
        "ec2:Describe*"
      ],
      "Resource": "*"
    }
  ]
    }
EOF
}

resource "aws_s3_bucket" "bucket" {

  bucket = "${var.bucket_name}"
  acl = "private"

}
