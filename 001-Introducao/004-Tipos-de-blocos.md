
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "001 Introdução - 004 Tipos de Blocos."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# Tipos de Blocos



curl -X POST -H 'Content-Type: application/json' \
    -H 'Authorization: Bearer '$TOKEN'' \
    -d '{"name":"ubuntu-s-1vcpu-1gb-sfo3-01",
        "size":"s-1vcpu-1gb",
        "region":"sfo3",
        "image":"ubuntu-23-10-x64",
        "monitoring":true,
        "tags":["ambiente:teste"]}' \
    "https://api.digitalocean.com/v2/droplets"