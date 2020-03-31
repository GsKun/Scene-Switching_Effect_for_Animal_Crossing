using UnityEngine;
using UnityEngine.Rendering;

public class AffectSceneSwitch : MonoBehaviour
{
    SceneSwitch ss;

    public bool isSwitch = false;
    public float speed = 5f;
    private bool forward = true;

    public float intervalTime = 0.8f;
    private float elapsedTime = 0f;

    void Start()
    {
        Volume vol = GetComponent<Volume>();

        SceneSwitch temp;

        if (vol.profile.TryGet<SceneSwitch>(out temp))
            ss = temp;
    }

    void Update()
    {
        if (ss == null) return;

        if (Input.GetKeyDown(KeyCode.Space))
        {
            isSwitch = true;
        }

        if (isSwitch)
        {
            if (forward && ss.scale.value != 0)
            {
                if (ss.scale.value <= 0.01)
                {
                    ss.scale.value = 0f;
                    forward = false;
                }
                else
                    ss.scale.value = Mathf.Lerp(ss.scale.value, 0, Time.deltaTime * speed);
            }
            else if (!forward && ss.scale.value != 1)
            {
                if (elapsedTime <= intervalTime)
                {
                    elapsedTime += Time.deltaTime;
                }
                else
                {
                    if (ss.scale.value >= 0.99f)
                    {
                        ss.scale.value = 1f;
                        forward = true;
                        isSwitch = false;
                        elapsedTime = 0f;
                    }
                    else
                        ss.scale.value = Mathf.Lerp(ss.scale.value, 1, Time.deltaTime * speed);
                }
            }
        }
    }
}
