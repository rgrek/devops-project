# Verification of the Helm Chart's Integrity and Provenance
**Overview:**
> Integrity is established by comparing a chart to a provenance record.
>
> Provenance records are stored in provenance files (*.prov*), which are stored alongside a packaged chart.
> Provenance files are generated at packaging time (`helm package --sign ...`), and can be checked by multiple commands, notably `helm install --verify`.
> 
> Provenance files provide cryptographic verification that a **chart has not been tampered with**, and **was packaged by a trusted provider**.

**Prerequisites:**
1. [Helm](https://helm.sh/docs/intro/install/) CLI installed
2. [GnuPG](https://www.gnupg.org/gph/en/manual/c14.html) Installed


## 1. import Chart Provider's public key to your keyring: ##

**WARNING:**
> [**GnuPG v2**](https://gnupg.org/faq/whats-new-in-2.1.html#nosecring) stores your keyring using a new format kbx on the default location ~/.gnupg/pubring.kbx.
> 
> *Addition:* Since gpg version **2.4.1**, **use-keyboxd** was introduced and makes GPG once again, behave differently.
>
> Sadly, converting keyring to legacy gpg format for `helm verify` to work properly is **required**. To do that, execute the below `commands`:

```
wget https://kreckyn.github.io/devops-project/helm-chart/pubring.gpg
gpg --import pubring.gpg
gpg --export > ~/.gnupg/pubring.gpg
```

**Cleanup:**
> In case you don't need this anymore, remove it from your keyring and clean up the exported gpg file.
```
gpg --delete-keys 3E349B0A0A8A32AD0664CA426ED728621C412B9B
rm -rf ~/.gnupg/pubring.gpg
```

## 2. Add and update a repository where the helm chart is stored: ##
```
helm repo add gitrepo https://kreckyn.github.io/devops-project/helm-chart
helm repo update
```

## 3. Verification ##
> **You have couple of options:**
> 1. *Verify the integrity at the same time as you install the helm chart.*
> 2. *Pull the chart along with the provenance file and verify manually.*

### 1. Verifying the integrity during installation: ###
```
helm install --generate-name --verify gitrepo/voting-app
```
**If verification fails, the install will be aborted before the chart is even rendered.** A failed verification looks like this:
>Error: INSTALLATION FAILED: sha256 sum does not match for voting-app-0.1.0.tgz: "sha256:5b8bd4b559e3830882367c2bf2370bf5878c30098a5607e733aae084b23eb5ff" != "sha256:19faf1850c0e9b6da639c6787a87aee0e8d6301b94abf7df4873a8518fef2217"
#
### 2. Pulling the chart along with the provenance file and verifying manually ###
```
helm pull gitrepo/voting-app --prov
helm verify voting-app-0.1.0.tgz
```
A failed verification looks like this:  
>Error: sha256 sum does not match for voting-app-0.1.0.tgz: "sha256:5b8bd4b559e3830882367c2bf2370bf5878c30098a5607e733aae084b23eb5ff" != "sha256:19faf1850c0e9b6da639c6787a87aee0e8d6301b94abf7df4873a8518fef2217"


# Note

> **If you are unable to verify chart's integrity and provenance using `helm verify`,** you can still **verify the file's checksum**.
>
> Note that, **this is less secure**, because if someone modified the files as they were transferred to you, it would not be much more effort to modify the checksums that you can see on this webpage.

