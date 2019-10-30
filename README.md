[Hero](https://github.com/HeroTransitions/Hero)是一个能快速添加转场动画的第三方框架，在Github上有17.5K的星。([中文说明](https://github.com/HeroTransitions/Hero/blob/develop/README.zh-cn.md))

**安装方法**
```
 pod 'Hero'
```
- **它可以实现的效果请进入Github上查看，下面实现说明中的两个简单实例**
---
### 简单实例一

![image](https://upload-images.jianshu.io/upload_images/11157535-b857391fc4cd01eb.gif?imageMogr2/auto-orient/strip)

- **先创建好两个控制器，确定最终要显示的界面**

>**$\color{#9400D3}{在控制器一中创建}$**
>
>黑色View，取名**blackView1**
>红色View，取名**redView1**

>**$\color{#9400D3}{在控制器二中创建}$**
>
>红色View，取名**redView2**
>黑色View，取名**blackView2**
>白色View，取名**whiteView2**

- **动画最底层的View（例如控制器二中红色View），不能是控制器自带的View，否则会出现动画短暂黑屏的BUG**

---

>**$\color{#9400D3}{接下来实现控制器一的动画代码}$**
>```swift
 >//id可以为任意名，但必须要与第二个控制器中相同View的id名相同才能实现动画
>redView1.hero.id = "redView"    
>blackView1.hero.id = "blackView"
>```

>**$\color{#9400D3}{然后实现控制器二的动画代码}$**
>```swift
>self.hero.isEnabled = true     //开启转场动画，建议在present或push前调用
 >
>//因为控制器一与控制器二相同View的id名相同，所以在转场时会自动调用动画
>redView2.hero.id = "redView" 
>blackView2.hero.id = "blackView"   
>
>//设置白色View的动画，y = 500 指的是从y = 500的地方移动到白色View的最终位置
>//.useGlobalCoordinateSpace，使白色View作为独立的View，不会因为父View的位置大小改变而改变
>whiteView2.hero.modifiers = [.translate(y:500),.useGlobalCoordinateSpace]
>```
**这样就完成了实例一，是不是非常简单。通过很少的代码就可以实现效果不错的转场动画。👏👏👏👏👏**

---

###简单实例二

![简单实例二](https://upload-images.jianshu.io/upload_images/11157535-a5b73d9c39552af9.gif?imageMogr2/auto-orient/strip)

- **同样要先写好两个控制器的界面**

>**$\color{#9400D3}{在控制器一中创建}$**
>
>灰色圆形View，取名为**greyView1**

>**$\color{#9400D3}{在控制器二中创建}$**
>
>灰色条状View，取名为**greyView2**
>红色的CollectionView，取名为**collectionView2**

---
>**$\color{#9400D3}{接下来实现控制器一的动画代码}$**
>
>```swift
>greyView1.hero.id = "greyView"
>```

>**$\color{#9400D3}{然后实现控制器二的动画代码}$**
>
>```swift
>greyView2.hero.id = "greyView"
>////层叠应用增加子视图的延迟修饰符(添加子视图动画时会有延迟加载)
>collectionView2.hero.modifiers = [.cascade]
>```
>**$\color{#9400D3}{并在循环利用cell的方法中(个人认为应该是在这个方法中)}$**
>```swift
>func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
>        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
>        cell.layer.cornerRadius = 10
>        cell.backgroundColor = .red
>   
>        /*-------------主要--------------*/
>        cell.hero.modifiers = [.fade,.scale(0.5)]   //在添加cell时为其添加动画[.fade(淡入淡出的效果),.scale(0.5)放大倍数为0.5]
>        /*------------------------------*/
>       
>        return cell
>    }
>```
**这样就完成了啦。(虽然还有点小BUG,在滑动之后隐藏会有重影效果)**

