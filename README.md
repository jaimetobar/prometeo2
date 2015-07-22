Add Redis cartridge to your application:

`rhc add-cartridge http://cartreflect-claytondev.rhcloud.com/reflect?github=smarterclayton/openshift-redis-cart --app myapp`

Add Sidekiq cartridge to your application:
`rhc add-cartridge http://cartreflect-claytondev.rhcloud.com/github/pranavpr/openshift-origin-cartridge-sidekiq --app myapp`


Backup DB:

https://gist.github.com/skyebook/3407646

Uploading a file from your working directory to your app-root/data directory
    rhc scp myapp upload somefile.txt app-root/data

  Downloading a file from your app-root/data directory to your working
directory
    rhc scp myapp download ./ app-root/data/somebigarchive.tar.gz


Setup environment variables

```
rhc env set \
  SMTP_ADDRESS='smtp.mandrillapp.com' \
  SMTP_PORT=587 \
  SMTP_DOMAIN='rhcloud.com' \
  SMTP_USER_NAME='cromero@redhat.com' \
  SMTP_PASSWORD='XXXXXXXXXXXXXXXXX' \
  SMTP_AUTHENTICATION='login' \
  SMTP_FROM='cromero@redhat.com' \
  REDIS_PASSWORD='XXXXXXXXXXXXXXXXX' \
  BUNDLE_WITHOUT='development test' -a [APPLICATION NAME]
```
