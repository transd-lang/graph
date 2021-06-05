
#lang transd


public module Export: {
	height: 200,
	width: 200,
	fileName: "/mnt/proj/tmp/graph.ppm"
	//fileName: "C:\\Users\\al\\Temp\\plot.ppm"
}

private module MainModule: {
    import: "Export",
    import: "Quad",
    fs: FileStream(),
    v: ByteArray(),
    _start: (λ  (resize v (* (* height width) 3)) 
        (with quad Quad( width ) n 0 m 0 k 0 byten 0
            (while (< n (- width 1)) (+= n 1)
                (while (< m (- height 1)) (+= m 1)
                    (set k (- (- height m) 1))
                    (set byten (+ (* 3 (* k width))(* 3 n)))
                    (shade quad (to-Double n) (to-Double m) byten v)
                )
                (= m 0)
            )
        )
        (with hdr String("P6 " width " " height " 255\n" )
            (open fs fileName "w")
            (write fs (to-bytes hdr) (size hdr))
            (write fs v (size v))
            (close fs)
            (textout "Image generated successfully.\n")
        )
)
}


class Quad: {
    hw: Int(),

    @init: (λ wid Int() 
                (set hw (/ wid 2))),

    shade: (λ x Double() y Double() byten Int() v ByteArray()
                (with t 0.0 f 0.0 shade 0
                    (= t (- (sqrt y) (abs (- (to-Double hw) x))))
                    (set f 
                        (if (and (<= t 1.0)(>= t -1.0))
                            (- 1.0 (abs t))
                        else 0.0
                        )
                    )
                    (set shade (to-Int (* 255.0 (- 1.0 f))))
                    (set-el v byten shade)
                    (set-el v (+ byten 1) shade)
                    (set-el v (+ byten 2) shade)

    ))
}
