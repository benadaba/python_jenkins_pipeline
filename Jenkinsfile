pipeline {
    agent any

    environment {
        VIRTUAL_ENV = "${env.WORKSPACE}/venv"
        PATH = "${env.VIRTUAL_ENV}/bin:${env.PATH}"
        DOCKER_IMAGE = ""
        DOCKER_CREDENTIALS_ID = 'dockerhub'
        DOCKERHUB_REPO = 'benadabankah/flask-app'
        NEXUS_CREDENTIALS_ID = 'nexus-credentials'
        NEXUS_REPO_URL = 'http://18.169.131.157:8081/repository/flask-app/'
        SONAR_SCANNER_HOME = tool 'SonarQube Scanner'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/benadaba/python_jenkins_pipeline.git'
            }
        }
        
        stage('Set up Python Environment') {
            steps {
                script {
                    sh 'python3 -m venv venv'
                    sh 'pip install --upgrade pip'
                    sh 'pip install wheel'
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    sh 'pip install -r requirements.txt'
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    sh 'pip install pytest'
                    sh 'pytest -v tests/'
                }
            }
        }

        stage('Build Wheel') {
            steps {
                script {
                    sh 'python setup.py bdist_wheel'
                }
            }
        }

        stage('Archive Artifacts') {
            steps {
                archiveArtifacts artifacts: 'dist/*.whl', fingerprint: true
            }
        }

        stage('Upload to Nexus') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: NEXUS_CREDENTIALS_ID, passwordVariable: 'NEXUS_PASSWORD', usernameVariable: 'NEXUS_USERNAME')]) {
                        sh """
                        curl -u $NEXUS_USERNAME:$NEXUS_PASSWORD --upload-file dist/*.whl ${NEXUS_REPO_URL}
                        """
                    }
                }
            }
        }

        stage('Install Wheel') {
            steps {
                script {
                    sh 'pip install dist/*.whl'
                }
            }
        }

        // stage('Run Application') {
        //     steps {
        //         script {
        //             sh 'nohup run-app &'
        //         }
        //     }
        // }
 stage('Build Docker Image') {
            steps {
                script {
                    // DOCKER_IMAGE = docker.build("${DOCKERHUB_REPO}:${env.BUILD_ID}")
                    DOCKER_IMAGE =  sh(script: "sudo docker build -t ${DOCKERHUB_REPO}:${env.BUILD_ID} .", returnStdout: true).trim()
                }
            }
        }

        // stage('Push Docker Image') {
        //     steps {
        //         // script {
        //         //     docker.withRegistry('https://registry.hub.docker.com', DOCKER_CREDENTIALS_ID) {
        //         //         DOCKER_IMAGE.push()
        //         //         DOCKER_IMAGE.push('latest')
        //         //     }
        //         // }
        //          script {
        //             withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
        //                 sh 'echo $DOCKER_PASSWORD | sudo docker login -u $DOCKER_USERNAME --password-stdin'
        //                 // sh "sudo docker push ${DOCKERHUB_REPO}:${env.BUILD_ID}"
        //                 sh "sudo docker tag ${DOCKERHUB_REPO}:${env.BUILD_ID}"
        //                 sh "sudo docker push ${DOCKERHUB_REPO}:${env.BUILD_ID}"
        //             }
        //         }
        //     }
        // }
        
        // stage('Run Docker Container') {
        //     steps {
        //         script {
        //             DOCKER_IMAGE.run('-p 5000:5000')
        //         }
        //     }
        }
    }
