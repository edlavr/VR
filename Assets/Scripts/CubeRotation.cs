using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CubeRotation : MonoBehaviour
{
    private Inspector _inspector;
    
    private void Awake()
    {
        _inspector = FindObjectOfType<Inspector>();
    }

    private void Update()
    {
        if (_inspector.rotationTime == 0)
        {
            transform.rotation = Quaternion.Euler(_inspector.rotationVector * 45);
            return;
        }
        transform.Rotate(_inspector.rotationVector, 360f / _inspector.rotationTime * Time.deltaTime);
    }
}
