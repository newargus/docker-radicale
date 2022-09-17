VERSION=$(curl -s -XGET https://api.github.com/repos/Kozea/Radicale/tags | grep name -m 1 | awk '{print $2}' | cut -d'"' -f2 | cut -d'v' -f2)

docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 \
-f Dockerfile \
-t newargus/radicale:latest \
-t newargus/radicale:"${VERSION}" \
--build-arg TAG_VERSION="${VERSION}" \
--cpu-quota="400000" \
--memory=16g \
--push .
