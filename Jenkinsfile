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
				dir('pkg/CAP_project') {
					sh 'TERM=dumb make -j $(nproc) --output-sync ci-test'
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
