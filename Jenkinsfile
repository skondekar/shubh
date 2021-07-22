library('piper-lib-os') _
node() {

  stage('Run Unit Test') {
    gctsExecuteABAPUnitTests( 
      script: this,
      host: 'https://10.34.156.145:8001',
      client: '300',
      abapCredentialsId: 'ABAPUserPasswordCredentialsId',
      repository: 'DEV003'      
    )
  }
  
  stage('Roll Back Commit') {
    gctsRollback( 
      script: this
    )
  }
}
