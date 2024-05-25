pipeline {
    agent any

    environment {
        VIRTUAL_ENV = "${env.WORKSPACE}/venv"
        PATH = "${env.VIRTUAL_ENV}/bin:${env.PATH}"
        DOCKER_IMAGE = ""
        DOCKER_CREDENTIALS_ID = 'dockerhub'
        DOCKERHUB_REPO = 'benadabankah/flask-app'
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

        // stage('Run Tests') {
        //     steps {
        //         script {
        //             sh 'pip install pytest'
        //             sh 'pytest -v'
        //         }
        //     }
        // }

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

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                        DOCKER_IMAGE.push()
                        DOCKER_IMAGE.push('latest')
                    }
                }
            }
        }
        
        stage('Run Docker Container') {
            steps {
                script {
                    DOCKER_IMAGE.run('-p 5000:5000')
                }
            }
        }
    }
}