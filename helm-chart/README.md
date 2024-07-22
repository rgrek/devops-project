# Verification of the Helm Chart during installation (recommended)
First Add and update a repository where the helm chart is stored
```
helm repo add gitrepo https://kreckyn.github.io/devops-project/helm-chart
helm repo update
```
#
Now, run the following command and helm should do the rest:
```
helm install --generate-name --verify gitrepo/voting-app
```


# Manual verification of the helm chart #

This section downloads the public key and imports it to your keyring and exports to the respective folder where it needs to be for `helm verify` command to work properly. 
```
wget https://kreckyn.github.io/devops-project/helm-chart/pubring.gpg
gpg --import pubring.gpg
gpg --export > ~/.gnupg/pubring.gpg
```
#
This section adds and updates a repository where the helm chart is stored 
```
helm repo add gitrepo https://kreckyn.github.io/devops-project/helm-chart
helm repo update
```
#
This section pulls the latest packaged helm chart version along with the provenance file. 
```
helm pull gitrepo/voting-app --prov
```

#
Verification 
```
helm verify voting-app-0.1.0.tgz
```

A failed verification looks like this:  
>Error: sha256 sum does not match for topchart-0.1.0.tgz: "sha256:1939fbf7c1023d2f6b865d137bbb600e0c42061c3235528b1e8c82f4450c12a7" != "sha256:5a391a90de56778dd3274e47d789a2c84e0e106e1a37ef8cfa51fd60ac9e623a"
