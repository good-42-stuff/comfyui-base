variable "TAG" {
  default = "slim"
}

group "default" {
  targets = ["common", "dev"]
}

# Common settings for all targets
target "common" {
  context = "."
  platforms = ["linux/amd64"]
}

# Regular ComfyUI image (CUDA 12.4)
target "regular" {
  inherits = ["common"]
  dockerfile = "Dockerfile"
  tags = [
    "good42stuff/comfyui:${TAG}",
    "good42stuff/comfyui:latest",
  ]
}

# Dev image for local testing
target "dev" {
  inherits = ["common"]
  dockerfile = "Dockerfile"
  tags = ["good42stuff/comfyui:dev"]
  output = ["type=docker"]
}

# Dev push targets (for CI pushing dev tags, without overriding latest)
target "devpush" {
  inherits = ["common"]
  dockerfile = "Dockerfile"
  tags = ["good42stuff/comfyui:dev"]
}

target "devpush5090" {
  inherits = ["common"]
  dockerfile = "Dockerfile.5090"
  tags = ["good42stuff/comfyui:dev-5090"]
}

# RTX 5090 optimized image (CUDA 12.8 + latest PyTorch build)
target "rtx5090" {
  inherits = ["common"]
  dockerfile = "Dockerfile.5090"
  tags = [
    "good42stuff/comfyui:${TAG}-5090",
    "good42stuff/comfyui:latest-5090",
  ]
}
