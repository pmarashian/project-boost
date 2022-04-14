using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Movement : MonoBehaviour
{

    Rigidbody rb;
    AudioSource audioSource;

    [SerializeField] private float angularSpeed = 5f;
    [SerializeField] private float thrust = 2f;
    [SerializeField] private AudioClip thrustClip;

    [SerializeField] private ParticleSystem mainThrustParticles;
    [SerializeField] private ParticleSystem thruster1Particles;
    [SerializeField] private ParticleSystem thruster2Particles;
    [SerializeField] private ParticleSystem thruster3Particles;
    [SerializeField] private ParticleSystem thruster4Particles;


    void Start()
    {
        rb = GetComponent<Rigidbody>();
        audioSource = GetComponent<AudioSource>();
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

            if (!audioSource.isPlaying)
            {
                audioSource.PlayOneShot(thrustClip);
            }

            if (!mainThrustParticles.isPlaying)
            {
                playParticles();
            }

        }
        else
        {
            audioSource.Stop();
            stopParticles();
        }
    }

    private void playParticles()
    {
        mainThrustParticles.Play();
        thruster1Particles.Play();
        thruster2Particles.Play();
        thruster3Particles.Play();
        thruster4Particles.Play();
    }

    private void stopParticles()
    {
        mainThrustParticles.Stop();
        thruster1Particles.Stop();
        thruster2Particles.Stop();
        thruster3Particles.Stop();
        thruster4Particles.Stop();
    }

    private void ProcessRotation()
    {
        if (Input.GetKey(KeyCode.LeftArrow))
        {
            ApplyRotation(1);
        }
        else if (Input.GetKey(KeyCode.RightArrow))
        {
            ApplyRotation(-1);
        }

    }

    private void ApplyRotation(float direction)
    {
        rb.freezeRotation = true;
        transform.Rotate(Vector3.forward * Time.deltaTime * angularSpeed * direction);
        rb.freezeRotation = false;
    }
}
