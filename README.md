# vmimport

Terraform provisioning for [AWS VM import](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/UsingImportImage.html). The resulting bucket can be referenced with Packer using e.g.:

```
"post-processors": [
  {
    "type": "amazon-import",
    "region": "eu-central-1",
    "s3_bucket_name": "name of your bucket",
    "tags": {
      "Description": "packer amazon-import {{timestamp}}"
    }
  }
]
```
