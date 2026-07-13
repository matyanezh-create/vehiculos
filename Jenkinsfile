pipeline {
    agent any

    parameters {
        string(name: 'DB_URL', defaultValue: '', description: 'URL JDBC de la base de datos Sucursal')
        string(name: 'DB_USERNAME', defaultValue: 'admin', description: 'Usuario de la base de datos')
        password(name: 'DB_PASSWORD', defaultValue: '', description: 'Contrasena de la base de datos')
    }

    triggers {
        githubPush()
    }

    environment {
        IMAGE_NAME = 'sucursal-vehiculos'
        CONTAINER_NAME = 'contenedor_vehiculos'
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
