# Preserve annotations
-keepattributes *Annotation*

# Keep javax.annotation classes
-dontwarn javax.annotation.**
-keep class javax.annotation.** { *; }

# Keep com.google.errorprone annotations
-dontwarn com.google.errorprone.annotations.**
-keep class com.google.errorprone.annotations.** { *; }

# Keep Google Crypto Tink classes
-dontwarn com.google.crypto.tink.**
-keep class com.google.crypto.tink.** { *; }
