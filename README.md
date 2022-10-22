# urovo_scan_manager

Flutter plugin that implement [Urovo ScanManager library](https://www.urovo.com/developer/android/device/ScanManager.html).

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter development, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

<details><summary><b>Чтобы работал сканер UROVO в релизной сборке</b></summary>
  <ul>
    <li>In the file <code>[project_name]/android/app/build.gradle</code>, add the line <code>            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
</code> to <code>buildTypes.release</code></li>
    <li>Create the <code>proguard-rules.pro</code> file in the <code>[project_name]/android/app</code> folder and add the line <code>-dontobfuscate</code></li>
  </ul>
</details>