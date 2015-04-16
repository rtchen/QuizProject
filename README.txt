Quizzes:


        We implemented the following question types: Question-Response, Fill in the blank, Multiple Choice, Picture Response, and Multiple Answers.  For the answers, we added the ability to include more than one accepted answer per slot.  We also included options for all the required quiz properties (multipage, random order and immediate result for multipage) and practice mode.
        We built a summary page for each quiz, containing information about the quiz creator, properties, and the average score.  It also has a list of recent attempts(with a link to the full history), top scores, and top scores from the current day.  
            We also allow user to write review and rates about the quiz.  These reviews are listed at the bottom of the quiz info page.


On the main index page, you can search for quizzes by their tag.  Any user can add a tag to any quiz on the QuizInfo page.


Users:
        We have a secure login system that stores a hashed version of the password and uses a salt.  
Each user will have their own home page as well as a profile page that can be accessed by other users whenever their name appears on the website.  There is a search bar where you can look for certain users and a drop down list where you can see your current friends’ profiles.  The user can also search for quizzes through a search bar; if a partially matched quiz exists, the user will be directed to this quiz page. Users also have a profile picture that they can update.


The information on a user’s own page includes any admin announcements, a list of popular quizzes, recently created quizzes, the user’s created quizzes, recent attempts (with a link to the full history), and a list of achievements that they’ve earned.  All these tables have links to relevant information like quiz pages and an overview of results


Achievements:
        We added in some basic achievements for when you’ve taken/created 1, 5, 10, 25, and 50 quizzes.  We also have achievements for getting the highest score and for practicing a quiz.


Administrator:
        Current administrators can promote regular users to administrators, or downgrade existing administrators. 
        Admin can post announcements, view site statistics, remove user accounts (and consequently all information related to the removed user in the database), view all quizzes and remove / clear history for any quiz.


Mail Messages:
The quiz website has its own internal mail system including the three messages types: friend request, challenge, and note.


For the Friend Request, the user can search for friends through the search box in the index page, and the result will link to the searched user’s public profile page, where there is a “Friend” button. Once the user clicks this button, it will direct to the “compose” page, where the user can send a friend request. The subject, recipient and message are filled up automatically using the template for composing a friend request message type, but the user can also customize his or her message. Upon receiving the friend request, the recipient can either accept or ignore it. “Accept” will add a friendship between the recipient and the sender, whereas “ignore” will do nothing but delete this message. Then, the system automatically sends a message back to the sender, informing him or her that the recipient has accepted the friend request.


For the Challenge, the user can send a challenge to his or her friends to take a certain quiz. On each quiz page, there is a button “Send a Challenge,” which links to the “compose“ page.  The user can either send a challenge before  or after his or her attempt to take the quiz. The user can choose a friend from the drop-down menu as the recipient in the “compose” page. Similar to Friend Request, the subject message are filled up automatically using the template for composing a challenge message type, including a hyperlink to the quiz page and the sender’s highest score for taking this quiz, but the user can customize his or her message as well. Once the recipient accepts the challenge, he or she will be redirected to the quiz page to take the quiz.


For the Note message type, the user can specify any subject and message contents and send it to anyone. Once the recipient receives the message, he or she has an option to reply to the message simply by clicking the “reply” button, or deletes the message.


In addition, the user can mark read or unread for all messages received. He or she can also read all the messages sent by himself or herself. The inbox notification will update accordingly to show the number of new unread notifications.
