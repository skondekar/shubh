@Library('piper-lib-os') _
node() {
    stage('Prepare') {
        checkout scm
        setupCommonPipelineEnvironment script:this
    }
 
}
node() {
    stage('Deploy') {
        gctsDeploy script: this
    }    
}
