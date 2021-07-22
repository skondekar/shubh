library('piper-lib-os') _
node() {
  stage('Run Unit Test') {
    piperPipeline script: this
    gctsExecuteABAPUnitTests script: this
  }
  
  stage('Roll Back Commit') {
    gctsRollback( 
      script: this
    )
  }
}
