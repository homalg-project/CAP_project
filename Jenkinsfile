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

				dir('pkg') {
					sh 'make -C "CAP_project/CAP" doc'
					sh 'make -C "CAP_project/CompilerForCAP" doc'
					sh 'make -C "CAP_project/MonoidalCategories" doc'
					sh 'make -C "CAP_project/CartesianCategories" doc'
					sh 'make -C "CAP_project/FreydCategoriesForCAP" doc'
					sh 'make -C "homalg_project/homalg" doc'
					sh 'make -C "homalg_project/Modules" doc'
				}

				dir('pkg/CAP_project') {
					sh 'make --trace -j $(nproc) --output-sync ci-test'
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
