# In case you would like to verify the integrity of the helm chart manually follow these instructions: #

# This section downloads the public key and imports it to your keyring and exports to the respective folder where it needs to be for `helm verify` command to work properly. 
1. wget https://kreckyn.github.io/devops-project/helm-chart/pubring.gpg
2. gpg --import pubring.gpg
3. gpg --export > ~/.gnupg/pubring.gpg 

# This section adds and updates a repository where the helm chart is stored 
1. helm repo add gitrepo https://kreckyn.github.io/devops-project/helm-chart
2. helm repo update

# This section pulls the latest packaged helm chart version along with the provenance file. 
1. helm pull gitrepo/voting-app --prov

# Verification 
1. helm verify voting-app-0.1.0.tgz

#  A failed verification looks like this:  
Error: sha256 sum does not match for topchart-0.1.0.tgz: "sha256:1939fbf7c1023d2f6b865d137bbb600e0c42061c3235528b1e8c82f4450c12a7" != "sha256:5a391a90de56778dd3274e47d789a2c84e0e106e1a37ef8cfa51fd60ac9e623a"
