# A Novel IoT-Based Problem Reporting System Utilising Human Sensors: A Case Study at University of Nottingham Malaysia

<h1>Nott-A-Problem (NAP) Mobile Application</h1>
<p>NAP emerged as a pioneering solution that speeds up the traditional problem-reporting process. NAP used cutting-edge AI models and a user-friendly mobile interface. This innovative approach aims not only to simplify and automate the reporting process but also to encourage a proactive culture of maintenance and issue resolution across the campus. Hence, NAP significantly reduces the barriers to reporting, ensuring that problems are addressed quickly and efficiently, thereby enhancing the overall campus experience for all community members.</p>

<h1>Motivation</h1>
<ul>
  <li>Existing problem-reporting system at UNM required users to navigate through multiple complex web interfaces and fill out extensive forms which can be time consuming
    <br/>
    <img src="https://github.com/YeoYiXin/Problem-Reporting-System/assets/89788614/7219cfe2-e29a-42d4-b556-df78feb26878" alt="drawing" width="500"/>
    <br/>
    <img src="https://github.com/YeoYiXin/Problem-Reporting-System/assets/89788614/5eb156bb-65c2-4897-9ce4-1bbe7081bdc3" alt="drawing" width="500"/>
  </li>
  <li>Consequently, many students and staff found the process so daunting that they resorted to either walking to relevant offices during working hours, making phone calls to report issues, or disregard the issue, a solution that clearly contradicts the principles of modern, digital-first campus environments.</li>
</ul>

<h1>Technology Stacks Used</h1>
<p><b>Framework: </b>Flutter</p>
<p><b>Programming Language: </b>Dart</p>
<p><b>Backend: </b> 
  <ul>
    <li>Google CloudRun for image classification AI model and GPT-4 problem verification and summarisation</li>
    <li>Firebase for user authentication, Cloud Firestore, and Storage</li>
  </ul>
</p>
<p>
  <b>AI models: </b>Python - custom train MobileNetV2 with TensorFlow and Keras
</p>

<h1>Features</h1>
<ul>
  <li>Accurate problem identification with minimal number of mistakes. All the models have an average accuracy of 90%</li>
  <li>Efficient error handling for wrong problem identification such as wrongly classified images, and problems with class not trained by the AI model.</li>
  <li>Well-structured duplication detection feature through problem matching.</li>
  <li>Accurate problem summarisation.</li>
  <li>Precise outdoor location detection.</li>
  <li>Automated priority, status, and department assignation.</li>
  <li>Effective problem verification before prompting user for the specific unseen problem classes.</li>
  <li>Easy-to-navigate mobile application user interface.</li>
  <li>Fast problem reporting process.</li>
  <li>Transparent system through allowing user to view user’s problem submission and other users’ problem report.</li>
  <li>Engaging application through gamification, which is point collection through successful problem submission</li>
  <li>Enhanced user experience interface through features such as password reset, profile picture customisation, contact administration, and help from security office.</li>
</ul>

<h2>Prerequisites before running the program</h2>
<p><b>System Requirements</b></p>
<p>To install and run Flutter, your development environment must meet these minimum requirements:</p>
<ul>
  <li><b>Operating Systems:</b> MacOS,Linux (64-bit) or Windows</li>
  <li><b>Disk Space:</b> 600 MB</li>
  <li><b>Tools:</b>  Either one or at least one of the command-line tools are available in your environment like bash, curl, file, git 2.x, mkdir, rm, unzip, which, xz-utils, zip</li>
</ul>
<br/>
<p><b>Platforms:</b></p>
<p>Have either <a href="https://developer.android.com/studio">Android Studio</a>, <a href="https://code.visualstudio.com/download">VSCode</a> or any IDE to open Flutter project</p>
<p>JDK</p>

 <h1>Installations</h1>
 <ol>
   <li>Install Flutter by following instructions from <a href="https://flutter.dev/">flutter.dev</a>. To summarise:
     <ul>
       <li>Select the appropriate operating system</li>
       <li>Download the flutter sdk to a preferred location on your local system.</li>
     </ul>
    </li>
   <li>Make sure to install the Flutter and Dart plugins. Follow the instruction in <a href="https://docs.flutter.dev/get-started/editor">Flutter documentation</a></li>
   <li>Download the repository as a zip file</li>
   <li>After the zip file gets downloaded, extract it using Winrar or ZIP</li>
   <li>Open the extracted folder and the same files and folders as of Git repository were obtained. This meant the Flutter projecr was successfully imported.</li>
   <li>At the terminal, add all available dependencies through
     <code>flutter pub get</code>
   </li>
 </ol>

<h1>Folder Structure</h1>
NAP project folder structure:
<code>
C:.
├───pages
│   ├───classifications
│   ├───dashboard
│   │   ├───components
│   │   ├───functions
│   │   └───services
│   └───login
│       ├───center_widget
│       ├───informationPage
│       ├───label
│       ├───models
│       ├───Registration
│       └───resources
└───services</code>

 <h1>Log in or Register Process</h1>
 <p>Log in with available account:</p>
 <p>Username: hfyyy3@nottingham.edu.my</p>
 <p>Passowrd:1234567890</p>

<h1>Mobile Application Pages</h1>
<br/>

<img src="https://github.com/YeoYiXin/Problem-Reporting-System/assets/89788614/388ba9cc-5388-477c-b557-24fea369eb42" alt="drawing" width="450"/>
<br/>

<img src="https://github.com/YeoYiXin/Problem-Reporting-System/assets/89788614/415cc4ef-a8e1-4602-8058-7dbbda48ae4c" alt="drawing" width="450"/>
<br/>

<h1>How to use?</h1>
<br/>

<img src="https://github.com/YeoYiXin/Problem-Reporting-System/assets/89788614/b1bba760-237e-4270-844f-7a57870da481" alt="drawing" width="450"/>
<br/>

<p>All credits belong to SEGP Group B 2023/24</p>
