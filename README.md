# My Nix Configurations

## Bootstrapping

```sh
nix flake init \
--template github:the-nix-way/home-manager-config-template
```

## Building

```sh
nix build '.#homeConfigurations.ziyunli.activationPackage'
./result/activate
```

## Update

```sh
nix flake update
```
