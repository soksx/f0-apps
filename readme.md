```powershell
docker build `
    --build-arg target_fw=ofw-v0.84.2 `
    --build-arg target_hw=f7 `
    -t bevir.io/f0-userapps:ofw-v0.84.2 --target pack-apps .

docker build `
    --build-arg target_fw=unlshd-052 `
    --build-arg target_hw=f7 `
    -t bevir.io/f0-userapps:unlshd-052 --target pack-apps .

docker build `
    --build-arg target_fw=RM0607-1145-0.84.3-81c9df5 `
    --build-arg target_hw=f7 `
    -t bevir.io/f0-userapps:RM0607-1145-0.84.3-81c9df5 --target pack-apps .
```