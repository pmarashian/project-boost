using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Ocsillate : MonoBehaviour
{

    Vector3 pos;
    Vector3 Movement = new Vector3(10f, 0, 0);
    [SerializeField] private float movementFactor = 0;

    // Start is called before the first frame update
    void Start()
    {
        pos = transform.position;
    }

    // Update is called once per frame
    void Update()
    {
        // multiply the movement factor by the time and sin
        movementFactor += Time.deltaTime;
        gameObject.transform.position = pos + Movement * Mathf.Sin(movementFactor);
    }
}
