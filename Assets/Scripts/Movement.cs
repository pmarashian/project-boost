using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Movement : MonoBehaviour
{

    Rigidbody rb;

    [SerializeField] private float angularSpeed = 5f;
    [SerializeField] private float thrust = 2f;


    void Start()
    {
        rb = GetComponent<Rigidbody>();
    }


    void Update()
    {
        ProcessRotation();
        ProcessThrust();
    }

    private void ProcessThrust()
    {
        if (Input.GetKey(KeyCode.Space))
        {
            rb.AddRelativeForce(Vector3.up * thrust * Time.deltaTime);
        }
    }

    private void ProcessRotation()
    {
        if (Input.GetKey(KeyCode.LeftArrow))
        {
            rotate(1);
        }
        else if (Input.GetKey(KeyCode.RightArrow))
        {
            rotate(-1);
        }

    }

    private void rotate(int direction)
    {
        transform.Rotate(Vector3.forward * Time.deltaTime * angularSpeed * direction);
    }
}
