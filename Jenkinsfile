library('piper-lib-os') _
node() {

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
