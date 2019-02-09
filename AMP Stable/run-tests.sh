git tag 1

git tag | tail -1

new_tag=($(git tag | tail -1) + 1)

echo $new_tag

git tag $new_tag

git push origin $new_tag
