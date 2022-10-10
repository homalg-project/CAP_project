pipeline {
	agent any

	triggers {
		cron(env.BRANCH_NAME == 'master' ? '00 04 * * *' : '')
	}

	options {
		checkoutToSubdirectory('pkg/CAP_project')
	}

	stages {
		stage('test') {
			steps {
				dir('pkg') {
					sh 'rm -rf homalg_project; git clone --depth 1 https://github.com/homalg-project/homalg_project.git'
				}

				dir('pkg/CAP_project') {
					sh 'make -j $(nproc) --output-sync ci-test'
				}
			}
		}
	}

	post {
		success {
			cleanWs()
		}
	}
}
