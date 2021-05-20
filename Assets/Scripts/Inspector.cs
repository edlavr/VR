using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Inspector : MonoBehaviour
{
    [Header("Cubes settings (set rotation time to 0 to produce a static 45deg render)")]
    public float rotationTime = 2f;
    public Vector3 rotationVector = Vector3.up;
}
