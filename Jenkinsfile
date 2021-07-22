library('piper-lib-os') _
node() {
  stage('Deploy') {
    gctsDeploy(
        script: this,
        host: 'http://10.34.156.145:8000',
        client: '300',
        abapCredentialsId: 'ABAPUserPasswordCredentialsId',
        repository: 'DEV003',
        remoteRepositoryURL: "https://github.com/skondekar/shubh",
        role: 'SOURCE',
        vSID: 'S4D',
        branch: 'master',
        commit: 'commit',
        scope: 'scope',
        rollback: false,
        configuration: [dummyConfig: 'dummyval']
    )
  }
}
