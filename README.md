<h1 align = center> Brown Field of Dreams </h1> 

<p align="center">
  <img width="460" height="300" src="https://cdn.business2community.com/wp-content/uploads/2014/07/field-of-dreams.jpg">
</p>

Contributers: 
[Sebastian Sloan](https://github.com/sasloan) , [Ezekiel Clark](https://github.com/Yetidancer)

  Welcome to Brown Field of Dreams! This project is designed to show the high level functions of a rails application. In this 
  project you will see how we have connected to external providers, shown infromation braught in by other providers as well as 
  see how to view imported youtube videos and much much more. We hope that you enjoy our project, should you have any
  questions, comments or concerns all feedback is welcome in the comment section below! 
  
  To view our project in production [click here](https://brownfield-dream.herokuapp.com/) .
  
 ```diff
  WARNING!! The seeded users that are provided in this app are only for this app please do not attempt to use them to 
  connect to any external provider. If you do then the seeded user will have access to your github, youtube ect. . . info
  this is not good. when interacting with the app please make your own user. Thank you.
 ```
 
 <h2> Setup </h2>
 
  In this next section we will teach you how to setup the `Brown Field of Dreams` on your own local device. As always if you 
  have any feedback on how to make this setup better please leave a comment below. 
  
  Let's get started! So first off you need to find a place in your local directory that you would like to keep the
  `Brown Field of Dreams` after you have found the perfect spot lets fork and clone!! 
  
  When you know where you want to store the device then scroll to the top of this page and click on the `Fork` button

<img width="1342" alt="Screen Shot 2020-03-29 at 11 37 30 AM" src="https://user-images.githubusercontent.com/51456013/77856281-45104400-71b3-11ea-8cea-41d5afd868ec.png">

  Next We will want to clone your new copy of the `BFD` to your local device. In order to do this. first you must copy the 
  SSH. To do this click on the `Clone or download` button and then copy the link that pops up!! 

  <img width="1293" alt="Screen Shot 2020-03-29 at 11 43 07 AM" src="https://user-images.githubusercontent.com/51456013/77856166-88b67e00-71b2-11ea-8c5b-258f842c64d2.png">
  
  Once you have this then lets go to your terminal and in the special spot you want to store this project we are going to run
  the following command.
  
  
<img width="1214" alt="Screen Shot 2020-03-29 at 11 45 57 AM" src="https://user-images.githubusercontent.com/51456013/77856217-e2b74380-71b2-11ea-942e-5f18bf50272e.png">

  You will notice that after the `git clone` command the rest of the code is simply what you copied from GitHub! Now once you
  press `return` then boom!!! you have `BFD` on your local device and you can mess with it all you want!!
  
  We Do still have a little bit more to work on however. Now that you have the start of the set up done now we need to set up 
  your local enviornment. 
  
  Lets begin by running `bundle install` This will pull all the gems from your new gem file and download them so you have
  everything you need to oporate this app. 
  
  once that is complete you will need to set up your database. 
  
  first you will need to run the following commands with all success: 
  
  `rake db:create`
  `rake db:migrate`
  `rake db:seed`
  
  once this is done then your Database will be set up and ready for you to use! 
  
  Now that the Database and the gems are all installed and ready to go we need to set up some API keys so that your `BFD` 
  works the way that it is expected to. In order to do this you will need to set up API Keys with both youtube and git hub. 
  If you have these set up then great!!! But if you do not then you should see this documentation to set them up before 
  continuing with the `Brown Field of Dreams` set up process.
  
  YouTube API key set up: [how to setup a youtube api](https://www.youtube.com/watch?v=pP4zvduVAqo)
  
  
  GitHub CLIENT_ID and SECRET_ID: [how to set up a gihub access point](https://www.knowband.com/blog/user-manual/get-github-client-id-client-secret-api-details/)
  
  For Testing purposes you will also need to setup a github token to make sure the test program is working. If you are not
  interested in the making the test program pass then this is not required but strongly encouraged. 

  GitHub Access Token: [how to get a github access token](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line)
  
  Once you have all your tokens set up and ready to go then we move on to the next section. We need a safe place in the app to
  store all your new access keys. Lets start by running 
  
  `figaro install` 
  
  This will create some cool things for us to work with most important is the `application.yml` file that will safely hold all
  your new keys!!! your `application.yml` file exists in your config so follow `/config/application.yml` to get to it. once 
  you are inside your `application.yml` file you will need to fill in all keys you just made from above. When you are done it
  should look something like this. 

  <img width="1049" alt="Screen Shot 2020-03-29 at 12 09 56 PM" src="https://user-images.githubusercontent.com/51456013/77856709-39724c80-71b6-11ea-804f-032e82b3d5ae.png">
  
  If it does then we are ready to run `rspec`.
  
  When the set up is done correctly then you should see this.
  
  
<img width="792" alt="Screen Shot 2020-03-29 at 12 43 26 PM" src="https://user-images.githubusercontent.com/51456013/77857475-e64ec880-71ba-11ea-9c30-3de7dc65e58f.png">

That is the end of your set up process!!!  

<h2> Conclusion </h2> 

  We hope that you enjoy our app!! if you have any questions comments or concerns then please fill free to ask in the comment
  section below. thank you for your time and intrest. 
  
  

  
  
  
  

