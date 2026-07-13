pipeline {
    agent any

    triggers {
        githubPush()
    }

    environment {
        IMAGE_NAME = 'sucursal-vehiculos'
        CONTAINER_NAME = 'contenedor_vehiculos'
        DB_URL = 'jdbc:mysql://database-1.cushcjzdbzvl.us-east-1.rds.amazonaws.com:3306/Sucursal?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true'
        DB_USERNAME = 'admin'
        DB_PASSWORD = credentials('rds-db-password')
    }

    stages {
        stage('Obtener codigo') {
            steps {
                checkout scm
            }
        }

        stage('Compilar WAR') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Crear imagen Docker') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$BUILD_NUMBER -t $IMAGE_NAME:latest .'
            }
        }

        stage('Desplegar contenedor Tomcat') {
            steps {
                sh 'docker stop $CONTAINER_NAME || true'
                sh 'docker rm $CONTAINER_NAME || true'
                sh '''docker run -d \\
                    --name $CONTAINER_NAME \\
                    --restart unless-stopped \\
                    -p 9090:8080 \\
                    -e DB_URL="$DB_URL" \\
                    -e DB_USERNAME="$DB_USERNAME" \\
                    -e DB_PASSWORD="$DB_PASSWORD" \\
                    $IMAGE_NAME:$BUILD_NUMBER'''
            }
        }
    }
}
