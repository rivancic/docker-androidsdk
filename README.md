# Android SDK and Gradle
Image for building Android applications.
You should obtain the licence of the related Android SDK and accept it before using this image.

Last build contains:
- Android Support Repository, revision 29
- Android Support Library, revision 23.2.1

## Usage
Mount your code on `/build` and run `gradle build`

Example:
`docker run -t -i --name android -v <path to your project>:/build/ rivancic/androidsdk /bin/bash`

## TODO 

- Slim the image with alpine linux as a base OS
- extract some variables in the docker file like in -> https://hub.docker.com/r/bwits/android-sdk-alpine/~/dockerfile/
