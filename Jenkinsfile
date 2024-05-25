pipeline{
  //agent which will run the application
  agent any

    environment{
        VIRTUAL_ENV = "${env.WORKSPACE}/venv"
        PATH = "${env.VIRTUAL_ENV}/bin:${env.PATH}"
        DOCKER_IMAGE = ""
        DOCKER_CREDENTIALS_ID = "dockerhub"
        DOCKERHUB_REPO = "benadabankah/flask-app"

    }

    stages{
       stage('01. Clone Repository'){
          steps{
            git branch: 'main', url: 'https://github.com/benadaba/python_jenkins_pipeline.git'
          }
       }
       stage('02. Set up python virtual environment'){
        steps{
            //NB: make sure python is installed on your jenkins server directly
            // sudo yum install python
            script {
               sh 'python3 -m venv venv' 
            //    sh 'pip install --upgrade pip'
               sh 'pip install wheel'
            }
        }
       }
       stage('03. Install dependencies'){
         steps{
            script {
                sh 'pip install -r requirements.txt'
            }
           
         }
       }
       stage('04. Run Unit Tests'){
         steps{
            script{
                sh 'pip install pytest'
                sh 'pytest -v tests/'
            }
         }
       }
    //    stage('05. Sonar Scanning'){}
    //    stage('06. Build python project into a wheel'){}
    //    stage('07. Archive Artifacts'){}
    //    stage('08. Test install the wheel'){}
    //    stage('09. Upload to Nexus'){}
    //    stage('10. Build Docker Image'){}
    //    stage('11. Push to Docker'){}
    //    stage('12. Update kubernetes deployment file'){}
    //    stage('13. Connect k8s cluster '){}
    //    stage('14. Apply Deploy '){}
    //    stage('15. Clean Up '){}
    //    stage('16. Send slack and email notifications '){}
    }

}