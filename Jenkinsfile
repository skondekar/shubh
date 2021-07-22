library('piper-lib-os') _

node() {
  stage('Prepare') {
      deleteDir()
      checkout scm
      setupCommonPipelineEnvironment script:this
  }  
  
  stage('Build')

  stage('Deploy Commit') {
    gctsDeploy(
      script: this,
      host: 'convtest01.brj4t0c5xzounazuu03dnn:44300',
      client: '100',
      abapCredentialsId: 'ABAPUserPasswordCredentialsId',
      repository: 'skondekar-shubh',
      remoteRepositoryURL: "https://github.com/skondekar/shubh",
      role: 'TARGET',
      vSID: 'S4D',
      branch: 'master',
      commit: 'commit',
      scope: 'scope',
      rollback: false,
      verbose: true,
      configuration: [dummyConfig: 'dummyval']   
    )
  }
  
  stage('Run Unit Test') {
    gctsExecuteABAPUnitTests script: this
  }
  
  stage('Roll Back Commit') {
    gctsRollback( 
      script: this
    )
  }
}
