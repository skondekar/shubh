library('piper-lib-os') _

node() {
  stage('Prepare') {
      deleteDir()
      checkout scm
      setupCommonPipelineEnvironment script:this
  }  
  
  stage('Build')
  
  stage('Run Unit Test') {
    gctsExecuteABAPUnitTests script: this
  }
  
  stage('Roll Back Commit') {
    gctsRollback( 
      script: this
    )
  }
}
