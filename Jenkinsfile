pipeline {
    agent any

    environment {
        VIRTUAL_ENV = "${env.WORKSPACE}/venv"
        PATH = "${env.VIRTUAL_ENV}/bin:${env.PATH}"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://your-repository-url.git'
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
                    sh 'pytest'
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
    }
}
