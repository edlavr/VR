using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Inspector1 : Inspector
{
    [Header("Setup - Please don't touch :)")]
    public GameObject projectionQuad;

    [Header("Inverse Distortion settings")]
    public float c1 = 0.3f;
    public float c2 = 0.5f;

    private Material projectionMat;
    private static readonly int _C1 = Shader.PropertyToID("_c1");
    private static readonly int _C2 = Shader.PropertyToID("_c2");
    private void Awake()
    {
        projectionMat = projectionQuad.GetComponent<Renderer>().material;
        projectionMat.SetFloat(_C1, c1);
        projectionMat.SetFloat(_C2, c2);
    }

}
