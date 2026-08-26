{
  description = "Eric's environment setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05"; # TODO: CAN I GET AWAY WITH STABLE? 
  };

  outputs = inputs: {
    packages = builtins.mapAttrs (system: pkgs: {
      hello = pkgs.hello;

      default = inputs.self.packages.${system}.hello;
    }) inputs.nixpkgs.legacyPackages;
  };
}
