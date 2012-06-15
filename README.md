Firstly, thank you for the opportunity, I really enjoyed to learn more about uploading. Before I used to create simple form uploads, but to achieve the Challenge objectives "create a form upload with progress feedback, without Apache or Nginx modules" I needed to learn, it was really cool.

I decided to split this project into small projects, the [Uploader in Node.js](https://github.com/phstc/uploader_nodejs) and the [Uplader client in Rails](https://github.com/phstc/uploader_rails). Kind of System of Systems. Node.js fits better for the upload (event-driven, non-blocking I/O) and Rails fits better for the client (gems, community, maturity etc).

##How it Works

* When an user go to the [superuploads](http://superuploads.herokuapp.com)
* Click in the menu Uploads -> New Upload
    1. A socket.io connection is opened 
* When the user Select a file
    1. The CoffeeScript submits a form to an hidden iFrame, targeting to the Node.js Uploader
    2. While Node.js is receiveing the upload buffer, it emits the percentage received to the client
    3. The client receives the upload percentage and update the view
    4. When the upload is finished the CoffeeScript sets an hidden input with the File Url
* The user fill the description
* Click in save
* ...

##Uploder Node.js

###Why Node.js?

I could do the Uploader using XmlHttpRequest or Flash, there are lot of cross-browser plugins for that, I also tried [file-uploader](https://github.com/valums/file-uploader), there is a [branch](https://github.com/phstc/uploader_rails/tree/valums-file-uploader) with this version. But in IE7+ the progress feedback didn't work, I also tried other plugins and I noticed the same problem. Only plugins entirely in Flash worked (usually have intrusive UI) then I decided to keep it in Node.js.

###Server

To configure Node.js on Amazon EC2, I followed my post [Configurando o Node.js no Amazon EC2](http://pablocantero.com/blog/2012/01/04/configurando-o-node-js-no-amazon-ec2/) (disabling Nginx). 
I like this post "recipe", it makes the server similar as a PaaS, but to do it more AutoScaling focused, it needs a different approach, add the Server SSH Keys in the GitHub, create an image, an initialization script to clone the repository, CloudWatch and ELB.

###Node modules

####[formidable](https://github.com/felixge/node-formidable)

Just to parse the form data.

####[zombie](https://github.com/assaf/zombie)

I tried to use zombie to test the full stack, but it didn't work with iFrame, even without the iFrame I got an error ```TypeError: Cannot call method 'dispatchEvent' of undefined```. I like Node.js, but sometimes it makes hard things easy and easy things hard. 

####[node-static](https://github.com/cloudhead/node-static)

I used the Node.js to serve the uploaded files. I would like to use Nginx to serve the static content, but even with ```proxy_pass``` + ```proxy_buffering off```, Nginx still buffering the upload, it doesn't allow the Node.js process to "stream" the upload. For a quick solution, I removed Nginx and used Node.js to serve the static content uploaded by the Uploader client.

####[socket.io](http://socket.io)

I used socket.io to emit the upload progress to the client, it has lot of fallbacks and is fully compatible with the Challenge requirements ```IE > 6, Firefox and Chrome```. 

##Uploader client Rails

###Why Rails

Nowadays Ruby became my main programming language, most part of my Ruby projects I used Rails, I'm really productive with them, that's the why I chose Ruby on Rails.

> became my main programming language

It means that I like the Ruby object model, the community... The Ruby ecosystem.

###Rails enviroment

I used these template http://drone.bz/49748da6-3c22-4b85-b4fe-3346a5865ce5 to create my Rails project.

```rails new superuploads --builder=http://drone.bz/49748da6-3c22-4b85-b4fe-3346a5865ce5.rb```

I also added Capyara, it isn't include in the template.

The Rails version is hosted on Heroku.

##Restrict the upload

To restrict the upload there are two trivials ways to do it or more depends on the context.

If the project are under the same domain/subdomain, the session can be shared, it means that ```user_id``` will be available in Node.js and Rails.

Other approach is to use a ```security_hash```, something like that ```security_hash = md5(private_key + user_id)```.

