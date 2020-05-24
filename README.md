# gcp_module
タイトル間違えました。現状はgcpのNWモジュール郡です。  

## ディレクトリ階層
以下の通り。編集するのはtfvarsのみで大丈夫です。

```
gcp_module/
   modules/
     module-main.tf
     module-variables.tf
   resources/
     resource-main.tf
     resource-varialbes.tf
     resource-vars.tfvars
```

## 実行方法
git clone後、以下の流れです。

```
git clone https://github.com/ptpt-free/gcp_module.git
cd gcp_module
terraform init -var-file=resources/resource-vars.tfvars resources/
terraform validate -var-file=resources/resource-vars.tfvars resources/
terraform plan -var-file=resources/resource-vars.tfvars resources/
```

applyは作成してもOKということを確認し、各自でお願いします。

## 基本設定
各ファイルの役割は以下のとおりです  

|ファイル名|役割|
|:--|:--|
|module-main.tf|VPC、subnet、internal-ip作成用のモジュール<br>利用するオプションを追加するならここで|
|module-varialbes.tf|module-main.tfで利用する変数を宣言。<br>デフォルトでnullを宣言しているため、resource側で宣言しない場合は作成されない|
|resource-main.tf|moduleを呼ぶためだけの場所<br>VPC作成のみを行うのであればvpcのみを記載する|
|resource-varialbe.tf|resource-main.tfで利用するための変数を受け渡す。<br>実際の変数はresource-vars.tfvasに記載|
|resource-vars.tfvars|VPC、subnet、internal-ip作成するための変数を記載する場所<br>ここですべての利用値を設定する|

## 編集方法
resource-vars.tfvarsのvpc,subnet,internal_ipの{}を編集します。基本的にサンプルコードに沿って修正を行えば複数サブネット指定に複数IP指定もできます。  
内部はnull値宣言をしているため、特定の変数を利用したくない等臨機応変に変更ができます。




