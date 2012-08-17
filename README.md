It's my solution to the Code Challenge [File Upload with Progress](https://github.com/phstc/uploader_rails/blob/master/BackendDeveloperChallengeUpdated.pdf).

I decided to split this project into two small projects, the [Uploader in Node.js](https://github.com/phstc/uploader_nodejs) and the [Uplader client in Rails](https://github.com/phstc/uploader_rails). It's a kind of System of Systems, Node.js fits better for the upload (event-driven, non-blocking I/O) and Rails fits better for the client (gems, community, maturity etc).

[![Build Status](https://secure.travis-ci.org/phstc/uploader_rails.png)](http://travis-ci.org/phstc/uploader_rails)


##How it Works

* When an user go to the [superuploads](http://superuploads.herokuapp.com)
* Click in the menu Uploads -> New Upload
    1. A socket.io connection is opened 
* When an user select a file
    1. The client submits a form to a hidden iFrame targeting the node.js uploader
    2. While uploader is receiveing the upload buffer, it emits the received percentage to the client
    3. The client receives the upload percentage and update the view
    4. When the upload is finished the client sets an hidden input with the file url
* The user fill the description & save
* ...

##Uploder Node.js

###Why Node.js?

I could do the Uploader using XmlHttpRequest or Flash, there are lot of cross-browser plugins for that, I also tested [file-uploader](https://github.com/valums/file-uploader), there is a [branch](https://github.com/phstc/uploader_rails/tree/valums-file-uploader) with this version, but only plugins entirely in Flash worked in all browsers then I decided to keep it in Node.js instead of browser based solutions. BTW... I don't like the idea to use Flash.

###Server

To configure Node.js on Amazon EC2, I followed my post [Configurando o Node.js no Amazon EC2](http://pablocantero.com/blog/2012/01/04/configurando-o-node-js-no-amazon-ec2/) (disabling Nginx). 
I like this post "recipe", it makes the server similar as a PaaS, but to do it more AutoScaling focused, it needs a different approach e.g. add the Server SSH Keys in the GitHub, create an image, an initialization script to clone the repository, CloudWatch and ELB.

###Node modules

####[node-static](https://github.com/cloudhead/node-static)

I would like to use Nginx to serve the static content, but even with ```proxy_buffering off```, Nginx still buffering the upload before send it to the Node.js. That's the why I used the node-static to serve the uploaded files. 

I found a 'bug' in the node-static, I fixed it and sent a [pull request #54](https://github.com/cloudhead/node-static/pull/54) to the project.

Recently [cloudhead](https://github.com/cloudhead) added me as a contributor in the project. I reviewed and merged few pull requests and started adding tests in the project. Firstly, integration tests, they were easier than unit tests in this case. I used [vows](https://github.com/cloudhead/vows), I also sent a [pull request #222](https://github.com/cloudhead/vows/pull/222) to vows.

In a high traffic scenario, I would like to remove the static content server from Node.js, maybe using [HAProxy](http://haproxy.1wt.eu/) proxying to Nginx or Apache and the Uploader.

####[socket.io](http://socket.io)

I used socket.io to emit the upload progress to the client, it has lot of fallbacks, making it fully compatible most used browsers.

Motivated by this project I created the [node-upload-progress](http://github.com/phstc/node-upload-progress) module to handle upload and progress. This module does not depends on socket.io, it uses a similar mechanism to [Nginx Upload Progress Module](http://wiki.nginx.org/HttpUploadProgressModule).

In a high traffic scenario, I would like to use the node-upload-progress approach instead of socket.io.

####[formidable](https://github.com/felixge/node-formidable)

Just to parse the form data.

####[mocha](https://github.com/visionmedia/mocha)

For tests.

##Uploader client Rails

###Why Rails?

Nowadays Ruby became my main programming language, most part of my Ruby projects I used Rails, I'm really productive with them, that's the why I chose Ruby on Rails.

> became my main programming language

It means that I like the Ruby object model, the community... The Ruby ecosystem.

###Rails enviroment

I used this template http://drone.bz/49748da6-3c22-4b85-b4fe-3346a5865ce5 to create my Rails project.

```rails new superuploads --builder=http://drone.bz/49748da6-3c22-4b85-b4fe-3346a5865ce5.rb```

I also added Capyara, it isn't include in the template.

The Rails version is hosted on Heroku.

##Security hash

As I decided to develop this Challenge splitting in Rails for the Client and Node.js for the Uploader. I felt that I didn't write much code, Rails makes CRUD operations easy, Node.js makes the upload easy, mixing both resulted in much less code.

To write a little bit more code, I wrote a security_hash mechanism to ensure that the upload request is valid. Client and Uploader know the SECRET_KEY, all upload requests must contain security_hash ```md5(SECRET_KEY + timestamp)``` and timestamp.

