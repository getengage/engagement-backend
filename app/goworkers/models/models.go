package models

import (
    "encoding/json"
    "github.com/ip2location/ip2location-go"
)

type EventsRaw struct {
    APIKeyID string `json:"api_key_id"`
    Bottom float64 `json:"bottom,string"`
    Count int `json:"count,string"`
    CreatedAt string `json:"created_at"`
    ID string `json:"id"`
    InViewport bool `json:"in_viewport"`
    InViewportAndVisible float64
    InViewportArr string `json:"in_viewport_arr"`
    IP2 ip2location.IP2Locationrecord
    IsVisible bool `json:"is_visible"`
    IsVisibleArr string `json:"is_visible_arr"`
    ReachedEnd bool
    Referrer string `json:"referrer"`
    RemoteIP string `json:"remote_ip"`
    ScrollDepth struct {
        q1 float64  // top quadrant
        q2 float64
        q3 float64
        q4 float64  // bottom quadrant
    }
    SessionID string `json:"session_id"`
    SourceURL string `json:"source_url"`
    Timestamp string `json:"timestamp"`
    Top float64 `json:"top,string"`
    UserAgent string `json:"user_agent"`
    WordCount float64 `json:"word_count,string"`
    XPos float64 `json:"x_pos,string"`
    XPosArr string `json:"x_pos_arr"`
    YPos float64 `json:"y_pos,string"`
    YPosArr string `json:"y_pos_arr"`
}

func (e *EventsRaw) SetIP2() {
    e.IP2 = ip2location.Get_all(e.RemoteIP)
}

func (e *EventsRaw) XPositions() (xs []float64) {
    json.Unmarshal([]byte(e.XPosArr), &xs)
    return
}

func (e *EventsRaw) YPositions() (xy []float64) {
    json.Unmarshal([]byte(e.YPosArr), &xy)
    return
}

func (e *EventsRaw) Visible() (v []bool) {
    json.Unmarshal([]byte(e.IsVisibleArr), &v)
    return
}

func (e *EventsRaw) Viewport() (v []bool) {
    json.Unmarshal([]byte(e.InViewportArr), &v)
    return
}
