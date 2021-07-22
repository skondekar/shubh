library('piper-lib-os') _
node() {
  stage('Deploy Commit') {
    gctsDeploy(
        script: this
    )
  }

  stage('Run Unit Test') {
    gctsExecuteABAPUnitTests( 
      script: this
    )
  }
  
  stage('Roll Back Commit') {
    gctsRollback( 
      script: this
    )
  }
}
