library('piper-lib-os') _
node() {
  stage('Create Repository') {
    gctsCreateRepository(
      script: this,
      host: 'https://fc-pun01-hana.india.rapidigm.com:8001',
      client: '300',
      abapCredentialsId: 'ABAPUserPasswordCredentialsId',
      repository: 'DEV003',
      remoteRepositoryURL: 'https://github.com/skondekar/shubh',
      role: 'SOURCE',
      vSID: 'S4D'
    )
  }
